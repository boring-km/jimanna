'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "e33527b7b08f31a3b9770697c5b7b002",
"icons/Icon-192.png": "4b49833095d53e170e62c422ddfb821c",
"manifest.json": "ed7a8f2bf6db29536b720edfeaa1abee",
"flutter_bootstrap.js": "8a0cea87f3d51212f722d51c38536c61",
"version.json": "d78ffc0c357cef7e9e1c2c4764cd5ec9",
"loading.gif": "d7d3ce55b02cf2cf6b00737094608996",
"favicon.ico": "a463c3d59126b562c9170edc27fa623a",
"index.html": "248e409b99ddddf202a9a843a609aa46",
"/": "248e409b99ddddf202a9a843a609aa46",
"main.dart.js": "f73f92bf03a958d4831061c5ff475c84",
"assets/AssetManifest.json": "bed74abac659c1e9ac09022ff477b030",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "614e928fc0158fea2afdf599f3f54838",
"assets/fonts/MaterialIcons-Regular.otf": "6590ec40485e17a27f9d92ff39aeaee8",
"assets/assets/images/home_desktop_bottom_button.png": "7dcd256d92cd63c7b73bb4e5fb831a3e",
"assets/assets/images/abad.png": "79cd92b73a74fba1ef2fce57ea9968dc",
"assets/assets/images/health.gif": "b39a05cd312b6d08f46f4299c946bcf9",
"assets/assets/images/home_image.png": "ddfc300f33b518f364353aaef2999e00",
"assets/assets/images/heart.gif": "4e4d6322547b32006573c42896d9fd2e",
"assets/assets/images/home_desktop_top.png": "e18ca0baffd9b480714f9fb6448eab8a",
"assets/assets/images/nintendo.png": "658ecace27ccd19e6a6c61be1bb18450",
"assets/assets/images/result_background.png": "67f0151867d6907f1dfb3171a60836e4",
"assets/assets/images/character_image.png": "5bbf9725bfff72655236745c1af9b872",
"assets/assets/images/error.jpg": "2391275fc1f6d46eca5e3fa426047a2d",
"assets/assets/images/emoji.gif": "d519204b04b9dbccc82bef1aace9921f",
"assets/assets/images/confirm_button.png": "5ca4b52e614d4cc216002959ca9d3e6c",
"assets/assets/images/name_background.png": "985e2fb8ebb9fe394218ba42de1e15fe",
"assets/assets/images/game_controller.png": "7bf3a0eb16ae0a570e4245557a465fa5",
"assets/assets/images/home_desktop_background.png": "64ff3b0cdfd8ed6d83bb3e0c704a5b44",
"assets/assets/images/draw_background.png": "06466d2f170088331a2a838171a1f7f5",
"assets/assets/images/home_desktop_bottom.png": "13f8053289b5fa5870e2d6e97f045626",
"assets/assets/images/star.gif": "e0f1b873b725468835b020a60f559d54",
"assets/assets/music/background_music.mp3": "4308a5edd7eb59aaffd5f2b892af7772",
"assets/assets/videos/intro_video_5s.mp4": "b56183e755f410772a8538b52cbac0ae",
"assets/assets/fonts/DungGeunMo.woff": "c87776a1e3da78257cce656a96e64932",
"assets/NOTICES": "f3b5f2bacc6de675cbccfa4ff8776364",
"assets/AssetManifest.bin": "7c54f0ce1689be4f7205067ba43f8aaa",
"assets/FontManifest.json": "e772a6bd406cb4923e62ed86605ef8a7",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"CNAME": "4deb1327190d1565a58620c2c1c1bcc9"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
