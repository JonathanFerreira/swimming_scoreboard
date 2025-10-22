import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="swimmer-loader"
export default class extends Controller {
  static targets = ["categorySelect", "swimmerSelect"]
  static values = { url: String }

  connect() {
  }

  loadSwimmers() {
    const categoryId = this.categorySelectTarget.value

    // Limpar o select de nadadores
    this.swimmerSelectTarget.innerHTML = '<option value="">Selecione um nadador</option>'

    if (categoryId) {
      console.log("Fetching swimmers for category:", categoryId)
      this.fetchSwimmers(categoryId)
    } else {
      console.log("No category selected")
    }
  }

  async fetchSwimmers(categoryId) {
    try {
      const url = `${this.urlValue}?category_id=${categoryId}`
      const response = await fetch(url, {
        method: 'GET',
        headers: {
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest'
        }
      })

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`)
      }

      const swimmers = await response.json()
      this.populateSwimmerSelect(swimmers)
    } catch (error) {
      this.showError('Erro ao carregar nadadores. Tente novamente.')
    }
  }

  populateSwimmerSelect(swimmers) {
    swimmers.forEach(swimmer => {
      const option = document.createElement('option')
      option.value = swimmer.id
      option.textContent = swimmer.name
      this.swimmerSelectTarget.appendChild(option)
    })
  }

  showError(message) {
    console.error(message)
  }
}
