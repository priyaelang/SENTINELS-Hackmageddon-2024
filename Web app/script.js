document.addEventListener("DOMContentLoaded", function() {
    const heatmapSection = document.getElementById('heatmap');
    heatmapSection.querySelector('p').textContent = 'Heatmap data will be displayed here.';

    const incidentsSection = document.getElementById('incidents');
    incidentsSection.querySelector('p').textContent = 'Incidents data will be displayed here.';

    const alertsSection = document.getElementById('alerts');
    alertsSection.querySelector('p').textContent = 'Real-time alerts will be displayed here.';

    document.getElementById('signup-form')?.addEventListener('submit', function(event) {
        event.preventDefault();
        alert('Signup form submitted');
    });

    document.getElementById('login-form')?.addEventListener('submit', function(event) {
        event.preventDefault();
        alert('Login form submitted');
    });
});
