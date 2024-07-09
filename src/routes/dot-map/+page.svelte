<script>

import { onMount } from "svelte";
import maplibregl from "maplibre-gl";
import * as pmtiles from "pmtiles";

import "../../assets/styles.css";

let pmtilesTrees = "/trees-toronto/toronto-trees-2015.pmtiles";

let map;

onMount(() => {

	let protocol = new pmtiles.Protocol();
	maplibregl.addProtocol("pmtiles", protocol.tile);

	map = new maplibregl.Map({
		container: "map",
		style: {
				version: 8,
				name: "Empty",
				glyphs: "https://schoolofcities.github.io/fonts/fonts/{fontstack}/{range}.pbf",
				sources: {},
				layers: [
					{
						id: "background",
						type: "background",
						paint: {
							"background-color": "#0D534D05",
						},
					},
				],
			},
		center: [-79.39, 43.71], 
		zoom: 12, 
		minZoom: 11,
		maxZoom: 14,
		bearing: -17,
		scrollZoom: false,
		attributionControl: false
	});

	
	map.addControl(new maplibregl.ScaleControl(), "top-right");
	map.addControl(new maplibregl.NavigationControl(), "top-left");
	map.addControl(new maplibregl.AttributionControl(), "bottom-right");

	map.touchZoomRotate.disable();

	map.on("load", function () {

		map.addSource("trees", {
			type: "vector",
			url: "pmtiles://" + pmtilesTrees,
			attribution: "<a href='https://github.com/felt/tippecanoe' target='_blank'>tippecanoe</a> | <a href='https://github.com/protomaps/PMTiles' target='_blank'>PMTiles</a> | <a href='https://open.toronto.ca/dataset/topographic-mapping-physical-location-of-trees/' target='_blank'>City of Toronto</a> | <a href='https://jamaps.github.io/' target='_blank'>Jeff Allen</a>, <a href='https://schoolofcities.utoronto.ca/' target='_blank'>School of Cities</a>"
		});

		map.addLayer({
			"id": "trees-bg",
			"type": "circle",
			"source": "trees",
			"source-layer": "trees",
			"paint": {
				"circle-color": [
					'case',
                    ['==', ['get', 'i'], 1], '#0D534D',
                    ['==', ['get', 'i'], 2], '#2c7748',
                    ['==', ['get', 'i'], 3], '#2c7768',
                    'white' 
					],
				"circle-radius": [
					'interpolate',
					['linear'],
					['zoom'],
					10,  
					2,
					14,
					6
				],
				"circle-opacity": [
					'interpolate',
					['linear'],
					['zoom'],
					12,  
					0.01,
					14,
					0.04
				]
			}
		})

		map.addLayer({
			"id": "trees",
			"type": "circle",
			"source": "trees",
			"source-layer": "trees",
			"paint": {
				"circle-color": [
					'case',
                    ['==', ['get', 'i'], 1], '#0D534D',
                    ['==', ['get', 'i'], 2], '#2c7748',
                    ['==', ['get', 'i'], 3], '#2c7768',
                    'white' 
					],
				'circle-radius': [
					'interpolate',
					['exponential', 2],
					['zoom'],
					10,  
					1,
					14,
					2
				],
				"circle-opacity": [
					'interpolate',
					['linear'],
					['zoom'],
					12,  
					1,
					14,
					1
				]
			}
		})

	})

})

</script>

<div id="top">
	DOT MAP OF 1,249,667 TREES ACROSS TORONTO 🌲🌳🌲🏡🌳🌸🌲 <a href="https://github.com/schoolofcities/trees-toronto" target="_blank">README.md</a>
</div>

<div id="map">
</div>

