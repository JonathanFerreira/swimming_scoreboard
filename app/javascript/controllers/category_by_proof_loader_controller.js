import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="category-by-proof-loader"
export default class extends Controller {
  static targets = ["proofSelect", "categorySelect"]
  static values = { url: String }

  connect() {
    console.log("Category by proof loader controller connected")
  }

  loadCategories() {
    const proofId = this.proofSelectTarget.value

    // Limpar o select de nadadores
    this.categorySelectTarget.innerHTML = '<option value="">Selecione uma categoria</option>'

    if (proofId) {
      console.log("Fetching categories for proof:", proofId)
      this.fetchCategories(proofId)
    } else {
      console.log("No proof selected")
    }
  }

  async fetchCategories(proofId) {
    try {
      const url = `${this.urlValue}?proof_id=${proofId}`
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

      const categories = await response.json()
      this.populateCategorySelect(categories)
    } catch (error) {
      this.showError('Erro ao carregar categorias. Tente novamente.')
    }
  }

  populateCategorySelect(categories) {
    categories.forEach(category => {
      const option = document.createElement('option')
      option.value = category.id
      option.textContent = category.name
      this.categorySelectTarget.appendChild(option)
    })
  }

  showError(message) {
    console.error(message)
  }
}
