
const locations = [
  { name: "テスト島1", lat: 35.6585805, lng: 139.7454329, id:1 },
  { name: "テスト島2", lat: 34.9875441, lng: 135.7592164, id:2 }
]
let map;

function initMap(){
  map = new google.maps.Map(document.getElementById('map'), {
  center: {lat: 33.514425, lng: 139.311842},
  zoom: 7
  });

  let currentWindow;

  locations.map(d => {
    const marker = new google.maps.Marker({
      position: {lat: d.lat, lng: d.lng},
      map: map
    });

    marker.addListener('click', () => {
      currentWindow && currentWindow.close();
      const url= `<%= link_to "${d.name}", "/maps/${d.id}" %>`
      const infoWindow = new google.maps.InfoWindow({content: url});
      infoWindow.open(map, marker);
      currentWindow = infoWindow;
    });
  });
}
