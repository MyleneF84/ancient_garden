import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"

Chart.register(...registerables)

export default class extends Controller {
  static values = { revenue: Array, bestSelling: Array, fulfillementRatio: Array };
  static targets = ["revenueChart", "bestSellingDonut", "overviewBar", "fulfillementRatioBar"];

  initialize() {
    const colors = ['#2a9d8f','#f4a261','#1B263B','#c3e6cb','#dc3545','#6c757d']

    // line chart
    const data = this.revenueValue.map((item) => item[1])
    const labels = this.revenueValue.map((item) => item[0])

    const ctx = this.revenueChartTarget;

    new Chart(ctx, {
      type: "line",
      data: {
        labels: labels,
        datasets: [{
          label: "Revenue $",
          data: data,
          borderWidth: 3,
          borderColor: colors[0],
          backgroundColor: "rgba(255, 159, 64, 0.2)",
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
    });

        /* donut chart */
    const donutOptions = {
      cutout: 85,
      legend: {position:'bottom', padding:5, labels: {pointStyle:'circle', usePointStyle:true}}
    };

    const chDonutData = this.bestSellingValue.map((item) => item[1])
    const labels1 = this.bestSellingValue.map((item) => item[0])

    const chDonut = this.bestSellingDonutTarget;
    if (chDonut) {
      new Chart(chDonut, {
          type: 'doughnut',
          data: {
            labels: labels1,
            datasets: [
              {
              backgroundColor: colors.slice(0,3),
              borderWidth: 0,
              data: chDonutData,
              label: 'Best sellers'
              }
            ],
          },
          options: donutOptions
      });
    };

    // bar chart 1

    const chBar1 = this.fulfillementRatioBarTarget;

    const labelsDay = this.fulfillementRatioValue.map((item) => item[0])
    const chBar1Data = this.fulfillementRatioValue.map((item) => item[1])
    const chBarDataU = this.fulfillementRatioValue.map((item) => item[2])

    console.log(this.revenueValue)
    console.log(this.fulfillementRatioValue)

    if (chBar1) {
      new Chart(chBar1, {
      type: 'bar',
      data: {
        labels: labelsDay,
        datasets: [{
          data: chBar1Data,
          backgroundColor: colors[0],
          label: "Fulfilled %"
        },
        {
          data: chBarDataU,
          backgroundColor: colors[1],
          label: "Unfulfilled %"
        }]
      },
      options: {
        legend: {
          display: false
        },
      }
      });
    };

      // bar chart 2

    const chBar2 = this.overviewBarTarget;
    const labels2 = ["Jan", "feb", "mar", "apr", "jun", "jul","aug"];

    const data2 = {
    labels: labels2,
    datasets: [{
      label: 'Overview',
      data: [65, 59, 80, 81, 56, 55, 40],
      backgroundColor: [
        'rgba(255, 99, 132, 0.2)',
        'rgba(255, 159, 64, 0.2)',
        'rgba(255, 205, 86, 0.2)',
        'rgba(75, 192, 192, 0.2)',
        'rgba(54, 162, 235, 0.2)',
        'rgba(153, 102, 255, 0.2)',
        'rgba(201, 203, 207, 0.2)'
      ],
      borderColor: [
        'rgb(255, 99, 132)',
        'rgb(255, 159, 64)',
        'rgb(255, 205, 86)',
        'rgb(75, 192, 192)',
        'rgb(54, 162, 235)',
        'rgb(153, 102, 255)',
        'rgb(201, 203, 207)'
      ],
      borderWidth: 1
    }]
  };
    new Chart(chBar2, {
        type: 'bar',
        data: data2,
        options: {
          scales: {
            y: {
              beginAtZero: true
            }
          }
        }
      }
    );
  }
}
