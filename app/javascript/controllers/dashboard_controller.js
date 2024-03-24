import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"

Chart.register(...registerables)

export default class extends Controller {
  static values = { revenue: Array, bestSelling: Array };
  static targets = ["revenueChart", "bestSellingDonut", "overviewBar", "fullfilementRatioBar"];

  initialize() {
    const colors = ['#007bff','#28a745','#333333','#c3e6cb','#dc3545','#6c757d']

    // line chart
    const data = this.revenueValue.map((item) => item[1])
    const labels = this.revenueValue.map((item) => item[0])

    const ctx = this.revenueChartTarget;

    new Chart(ctx, {
      type: "line",
      data: {
        labels: labels,
        datasets: [{
          data: data,
          label: "Revenue $",
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
              label: "Best sellers"
              }
            ],
          },
          options: donutOptions
      });
    };

    // bar chart 1

    const chBar1 = this.fullfilementRatioBarTarget;
    if (chBar1) {
      new Chart(chBar1, {
      type: 'bar',
      data: {
        labels: ["M", "T", "W", "T", "F", "S", "S"],
        datasets: [{
          data: [589, 445, 483, 503, 689, 692, 634],
          backgroundColor: colors[0],
          label: "fulfilled"
        },
        {
          data: [639, 465, 493, 478, 589, 632, 674],
          backgroundColor: colors[1],
          label: "unfulfilled"
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
