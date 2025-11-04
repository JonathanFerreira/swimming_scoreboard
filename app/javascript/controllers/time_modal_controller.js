import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "swimmerName", "battery", "input", "saveButton"]

  connect() {
    this.setupInputFormatting()
    console.log('TimeModalController connected')
  }

  // Função para abrir o modal
  open(event) {
    console.log('open called', event)
    // Buscar a linha da tabela (tr) que contém o botão clicado
    const laneRow = event.currentTarget.closest('tr')
    if (!laneRow) {
      console.error('Lane row not found')
      return
    }

    // Ler os atributos data-time-modal-* da linha
    const laneId = laneRow.dataset.timeModalLaneIdValue
    const swimmerName = laneRow.dataset.timeModalSwimmerNameValue
    const battery = laneRow.dataset.timeModalBatteryValue
    const currentTime = laneRow.dataset.timeModalCurrentTimeValue || ''
    const csrfToken = laneRow.dataset.timeModalCsrfTokenValue
    const refereeMode = laneRow.dataset.timeModalRefereeModeValue === 'true'

    console.log('Modal data:', { laneId, swimmerName, battery, currentTime, csrfToken, refereeMode })

    if (!laneId || !swimmerName || !battery) {
      console.error('Missing required data:', { laneId, swimmerName, battery })
      return
    }

    // Preencher informações no modal
    this.swimmerNameTarget.textContent = swimmerName
    this.batteryTarget.textContent = `${battery}ª bateria`
    this.inputTarget.value = currentTime
    this.inputTarget.setAttribute('data-original-value', currentTime)
    this.inputTarget.setAttribute('data-lane-id', laneId)
    this.inputTarget.setAttribute('data-csrf-token', csrfToken)
    this.inputTarget.setAttribute('data-referee-mode', refereeMode)

    // Mostrar modal
    this.modalTarget.classList.remove('hidden')
    // Não bloquear scroll do body para evitar fundo branco
    // document.body.style.overflow = 'hidden'

    // Focar no input e selecionar o texto
    setTimeout(() => {
      this.inputTarget.focus()
      this.inputTarget.select()
    }, 100)
  }

  // Função para fechar o modal
  close() {
    // Restaurar valor original
    const originalValue = this.inputTarget.getAttribute('data-original-value') || ''
    this.inputTarget.value = originalValue

    // Esconder modal
    this.modalTarget.classList.add('hidden')
    // document.body.style.overflow = ''
  }

  // Função para salvar o tempo
  async save() {
    const timeValue = this.inputTarget.value.trim()
    const laneId = this.inputTarget.getAttribute('data-lane-id')
    const csrfToken = this.inputTarget.getAttribute('data-csrf-token')
    const refereeMode = this.inputTarget.getAttribute('data-referee-mode') === 'true'

    // Validação básica do formato
    const timeRegex = /^[0-9]{2}:[0-9]{2}\.[0-9]{3}$/
    if (timeValue && !timeRegex.test(timeValue)) {
      alert('Formato inválido! Use MM:SS.mmm (ex: 01:23.456)')
      this.inputTarget.focus()
      return
    }

    // Mostrar loading
    const originalText = this.saveButtonTarget.innerHTML
    this.saveButtonTarget.innerHTML = '<svg class="w-4 h-4 inline mr-1 animate-spin" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>Salvando...'
    this.saveButtonTarget.disabled = true

    try {
      // Determinar a URL baseada no modo
      const url = refereeMode
        ? `/referee/swimming_marker_lanes/${laneId}/update_time`
        : `/admin/swimming_marker_block_lists/${this.inputTarget.getAttribute('data-block-id')}/update_time`

      // Fazer requisição AJAX
      const response = await fetch(url, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({
          lane_id: laneId,
          recorded_time: timeValue
        })
      })

      const data = await response.json()

      if (data.success) {
        // Atualizar display na linha correspondente
        const laneRow = document.querySelector(`[data-time-modal-lane-id-value="${laneId}"]`)
        if (laneRow) {
          // Buscar o controller referee-time-display usando a API do Stimulus
          const displayController = this.application.getControllerForElementAndIdentifier(laneRow, 'referee-time-display')
          if (displayController) {
            displayController.updateTimeDisplay(data.recorded_time, data.recorded_date)
          } else {
            // Fallback: atualizar diretamente se não encontrar o controller
            const displayTarget = laneRow.querySelector('[data-referee-time-display-target="display"]')
            if (displayTarget) {
              if (data.recorded_time) {
                displayTarget.innerHTML = `
                  <div class="inline-flex items-center px-3 py-1 rounded-full text-sm font-semibold bg-green-100 text-green-800">
                    ${data.recorded_time}
                  </div>
                `
              } else {
                displayTarget.innerHTML = `<span class="text-gray-400 text-sm">-</span>`
              }
            }
          }
        }

        // Fechar modal
        this.close()
      } else {
        alert('Erro ao salvar: ' + (data.errors ? data.errors.join(', ') : 'Erro desconhecido'))
      }
    } catch (error) {
      console.error('Error:', error)
      alert('Erro ao salvar o tempo. Tente novamente.')
    } finally {
      // Restaurar botão
      this.saveButtonTarget.innerHTML = originalText
      this.saveButtonTarget.disabled = false
    }
  }

  // Configurar formatação automática do input
  setupInputFormatting() {
    // Formatação automática do input do modal
    this.inputTarget.addEventListener('input', (e) => {
      let value = e.target.value.replace(/\D/g, '') // Remove tudo que não é dígito

      if (value.length >= 1) {
        value = value.substring(0, 2) + ':' + value.substring(2, 4) + '.' + value.substring(4, 7)
      }

      e.target.value = value
    })

    // Validação em tempo real
    this.inputTarget.addEventListener('blur', (e) => {
      const value = e.target.value
      const timeRegex = /^[0-9]{2}:[0-9]{2}\.[0-9]{3}$/

      if (value && !timeRegex.test(value)) {
        e.target.classList.add('border-red-500')
        e.target.classList.remove('border-gray-300')
      } else {
        e.target.classList.remove('border-red-500')
        e.target.classList.add('border-gray-300')
      }
    })

    // Permitir fechar com ESC
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && !this.modalTarget.classList.contains('hidden')) {
        this.close()
      }
    })
  }
}
