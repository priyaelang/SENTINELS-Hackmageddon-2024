function openTab(tabName) {
    var i, tabContent;
    tabContent = document.getElementsByClassName("tab-content");
    for (i = 0; i < tabContent.length; i++) {
        tabContent[i].style.display = "none";
        tabContent[i].classList.remove("active");
    }
    document.getElementById(tabName).style.display = "block";
    document.getElementById(tabName).classList.add("active");
  
    if (tabName === 'dashboard') {
        renderChart();
    }
  }
  
  function renderChart() {
    const ctx = document.getElementById('crowdChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['12PM', '13PM', '14PM', '15PM', '16PM', '17PM', '18PM', '19PM', '20PM', '21PM', '22PM', '23PM'],
            datasets: [
                {
                    label: 'Humidity (%)',
                    data: [65, 59, 80, 81, 56, 55, 40, 60, 70, 90, 75, 85],
                    borderColor: 'rgba(75, 192, 192, 1)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    fill: true,
                },
                {
                    label: 'Temperature (°C)',
                    data: [20, 22, 25, 30, 28, 35, 40, 38, 30, 25, 22, 20],
                    borderColor: 'rgba(255, 99, 132, 1)',
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    fill: true,
                },
                {
                    label: 'Wind Speed (km/h)',
                    data: [12, 19, 3, 5, 2, 3, 10, 20, 15, 25, 30, 18],
                    borderColor: 'rgba(54, 162, 235, 1)',
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    fill: true,
                },
                {
                    label: 'Precipitation (mm)',
                    data: [50, 60, 40, 70, 90, 100, 80, 60, 70, 80, 60, 50],
                    borderColor: 'rgba(153, 102, 255, 1)',
                    backgroundColor: 'rgba(153, 102, 255, 0.2)',
                    fill: true,
                },
            ]
        },
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: 'Crowd Density Factors Over the Year',
                    font: {
                        size: 18
                    }
                },
                tooltip: {
                    mode: 'index',
                    intersect: false,
                },
                hover: {
                    mode: 'nearest',
                    intersect: true
                }
            },
            scales: {
                x: {
                    display: true,
                    title: {
                        display: true,
                        text: 'Time (24 hour format)'
                    }
                },
                y: {
                    display: true,
                    title: {
                        display: true,
                        text: 'Value'
                    }
                }
            }
        }
    });
  }
  
  function analyzeCrowd(event) {
      event.preventDefault(); // Prevent form from submitting the traditional way
  
      const imagePath = document.getElementById('imagePath').value;
      const threshold = document.getElementById('threshold').value;
  
      fetch('/predict', {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json',
          },
          body: JSON.stringify({ imagePath: imagePath, threshold: parseInt(threshold) }),
      })
      .then(response => response.json())
      .then(data => {
          if (data.alert) {
              showAlert(`Alert! The number of people (${data.number_of_people}) exceeds the threshold (${threshold}).`);
          } 
      })
      .catch(error => {
          console.error('Error:', error);
      });
  }
  
  function showAlert(message) {
      const alertBox = document.getElementById('alertBox');
      const alertMessage = document.getElementById('alertMessage');
      alertMessage.textContent = message;
      alertBox.style.display = 'block';
  }
  
  function closeAlert() {
      const alertBox = document.getElementById('alertBox');
      alertBox.style.display = 'none';
  }
  
  // Render the chart by default when the page loads
  window.onload = function() {
    openTab('dashboard');
    setTimeout(function() {
        alert("Higher Crowd Density Detected!");
    }, 8000);
  };
