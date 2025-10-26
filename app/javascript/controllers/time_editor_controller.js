import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "edit", "input", "saveButton", "cancelButton", "editButton"]
  static values = {
    laneId: Number,
    blockId: Number,
    csrfToken: String
  }

  connect() {
    this.setupInputFormatting()
  }

  // Função para habilitar edição do tempo
  editTime() {
    this.displayTarget.classList.add('hidden')
    this.editTarget.classList.remove('hidden')

    // Focar no input e selecionar o texto
    setTimeout(() => {
      this.inputTarget.focus()
      this.inputTarget.select()
    }, 100)
  }

  // Função para cancelar edição
  cancelEdit() {
    // Restaurar valor original
    const originalValue = this.inputTarget.getAttribute('data-original-value') || ''
    this.inputTarget.value = originalValue

    this.displayTarget.classList.remove('hidden')
    this.editTarget.classList.add('hidden')
  }

  // Função para salvar o tempo
  async saveTime() {
    const timeValue = this.inputTarget.value.trim()

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
      // Fazer requisição AJAX
      const response = await fetch(`/admin/swimming_marker_block_lists/${this.blockIdValue}/update_time`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': this.csrfTokenValue
        },
        body: JSON.stringify({
          lane_id: this.laneIdValue,
          recorded_time: timeValue
        })
      })

      const data = await response.json()

      if (data.success) {
        this.updateTimeDisplay(data.recorded_time, data.recorded_date)
        this.cancelEdit()
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

  // Função para atualizar a exibição do tempo
  updateTimeDisplay(recordedTime, recordedDate) {
    if (recordedTime) {
      this.displayTarget.innerHTML = `
        <div class="bg-green-50 border border-green-200 rounded-lg p-3">
          <p class="text-2xl font-bold text-green-700">${recordedTime}</p>
          <p class="text-xs text-green-600 mt-1">${recordedDate}</p>
        </div>
      `
    } else {
      this.displayTarget.innerHTML = `
        <div class="bg-gray-50 border border-gray-200 rounded-lg p-3">
          <p class="text-lg font-medium text-gray-500">Sem tempo registrado</p>
          <p class="text-xs text-gray-400 mt-1">Aguardando cronometragem</p>
        </div>
      `
    }
  }

  // Configurar formatação automática do input
  setupInputFormatting() {
    // Salvar valor original
    this.inputTarget.setAttribute('data-original-value', this.inputTarget.value)

    // Formatação automática
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
  }
}
