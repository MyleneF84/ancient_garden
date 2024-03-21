import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"

Chart.register(...registerables)

export default class extends Controller {

  initialize() {
    const data = [10, 20, 30, 40, 50, 60, 70]
    const labels = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"]

    const ctx = document.getElementById("revenueChart").getContext("2d")

    new Chart(ctx, {
      type: "line",
      data: {
        labels: labels,
        datasets: [{
          label: "Revenue $",
          data: data,
          borderWidth: 3,
          // borderColor: "#ee9b00",
          // backgroundColor: "#f4d35e",
          fill: true
        }]
      },
      options: {
        plugins: {
          legend: {
            display: false
          }
        },
        scales: {
          x: {
            grid: {
              display: false
            }
          },
          y: {
            border: {
              dash: [5, 5]
            },
            grid: {
              color: "#415A77"
            },
            beginAtZero: true
          }
        }
      }
    })
  }
}
