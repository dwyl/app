window.addEventListener('load', function(ev) {
  // Flutter init JS code
  loadScript('flutter.js').then(() => {
    // Download main.dart.js
    _flutter.loader.loadEntrypoint({
      serviceWorker: {
        serviceWorkerVersion: serviceWorkerVersion,
      },
      onEntrypointLoaded: async function(app) {
        let appRunner = await app.initializeEngine();
        await appRunner.runApp();
        // Remove loading screen when App available: 
        document.querySelector('#loading').remove();
      }
    });
  })
});

function loadScript(src) {
  return new Promise(function (resolve, reject) {
    var script = document.createElement('script');
    script.src = src;
    script.onload = function () { resolve(); };
    script.onerror = function () { reject(); };
    document.body.appendChild(script);
    console.log('loaded ', src)
  });
}