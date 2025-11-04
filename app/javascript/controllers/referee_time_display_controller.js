import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display"]
  static values = {
    laneId: Number,
    swimmerName: String,
    battery: Number,
    currentTime: String
  }

  connect() {
    // Controller apenas para exibir o tempo na tabela do referee
    // A lógica de edição é gerenciada pelo time-modal controller
    console.log('RefereeTimeDisplayController connected')
  }

  // Função para atualizar a exibição do tempo
  updateTimeDisplay(recordedTime, recordedDate) {
    if (recordedTime) {
      this.displayTarget.innerHTML = `
        <div class="inline-flex items-center px-3 py-1 rounded-full text-sm font-semibold bg-green-100 text-green-800">
          ${recordedTime}
        </div>
      `
    } else {
      this.displayTarget.innerHTML = `
        <span class="text-gray-400 text-sm">-</span>
      `
    }
  }
}
