<!DOCTYPE HTML>
<html lang="en">
  <head>
    <title>Aurora LIVE (WebGL Globe)</title>
    <meta charset="utf-8">
    <style type="text/css">
      html {
        height: 100%;
      }
      body {
        margin: 0;
        padding: 0;
        background: #000000 url(static/loading.gif) center center no-repeat;
        color: #ffffff;
        font-family: sans-serif;
        font-size: 13px;
        line-height: 20px;
        height: 100%;
      }

		#space-weather {
		 font-size: 11px;
        position: absolute;
        top: 150px;
        border-radius: 3px;
        left: 10px;
        padding: 10px;
		}
      #twitfeed {

        font-size: 11px;
        position: absolute;
	float: right;
        bottom: 50px;
        border-radius: 3px;
        right: 10px;
        padding: 10px;

      }

      #info {

        font-size: 11px;
        position: absolute;
        bottom: 5px;
        background-color: rgba(0,0,0,0.8);
        border-radius: 3px;
        right: 10px;
        padding: 10px;

      }

      #currentInfo {
        display: none;
        width: 270px;
        position: absolute;
        left: 20px;
        top: 63px;

        background-color: rgba(0,0,0,0.2);

        border-top: 1px solid rgba(255,255,255,0.4);
        padding: 10px;
      }

      a {
        color: #aaa;
        text-decoration: none;
      }
      a:hover {
        text-decoration: underline;
      }

      .bull {
        padding: 0 5px;
        color: #555;
      }

      #title {
        position: absolute;
        top: 20px;
        width: 270px;
        left: 20px;
        background-color: rgba(0,0,0,0.2);
        border-radius: 3px;
        font: 20px Georgia;
        padding: 10px;
      }

      .year {
        font: 16px Georgia;
        line-height: 26px;
        height: 30px;
        text-align: center;
        float: left;
        width: 90px;
        color: rgba(255, 255, 255, 0.4);

        cursor: pointer;
        -webkit-transition: all 0.1s ease-out;
      }

      .year:hover, .year.active {
        font-size: 23px;
        color: #fff;
      }

      #ce span {
        display: none;
      }

      #ce {
        width: 107px;
        height: 55px;
        display: none;
        position: absolute;
        bottom: 15px;
        left: 20px;
        background: url(static/ce.png);
      }


    </style>
  </head>
  <body>

  <div id="container"></div>

  <div id="info">
    <strong><a href="http://www.chromeexperiments.com/globe">WebGL Globe</a></strong> <span class="bull">&bull;</span>�Created by the Google Data Arts Team <span class="bull">&bull;</span> Data acquired from <a href="http://www.swpc.noaa.gov">NOAA SWPC</a>
  </div>

  <div id="currentInfo">
    <span id="year1990" class="year">1990</span>
    <span id="year1995" class="year">1995</span>
    <span id="year2000" class="year">2000</span>
  </div>

  <div id="title">
    Aurora LIVE
  </div>

<div id="space-weather">

	<table class="current_conditions">
		<caption>
			Current Geomagnetic Field Conditions at<br> <span
				id="measure-time"></span> <abbr title="Universal Time">UT</abbr>
		</caption>
		<tbody>
			<tr>
				<th>Zones</th>
				<th>Activity</th>
			</tr>
			<tr>
				<td>Polar</td>
				<td id="pol_status"></td>
			</tr>
			<tr>
				<td>Auroral</td>
				<td id="aur_status"></td>
			</tr>
			<tr>
				<td>Sub-Auroral</td>
				<td id="sub_status"></td>
			</tr>
		</tbody>
	</table>

</div>
<div id="twitfeed">
  <a class="twitter-timeline" href="https://twitter.com/search?q=%23Aurora" data-widget-id="349990484522979328">Tweets about "#Aurora"</a>
  <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>

<script charset="utf-8" src="http://widgets.twimg.com/j/2/widget.js"></script>
<script>
new TWTR.Widget({
  version: 2,
  type: 'search',
  search: '#aurora',
  interval: 30000,
  title: '#aurora',
  subject: 'Aurora Twitter Feed',
  width: 250,
  height: 300,
  theme: {
    shell: {
      background: '#000000',
      color: '#cccccc'
    },
    tweets: {
      background: '#333333',
      color: '#cccccc',
      links: '#3ca8e8'
    }
  },
  features: {
    scrollbar: true,
    loop: true,
    live: true,
    behavior: 'default'
  }
}).render().start();
</script>
</div>

  <a id="ce" href="http://www.chromeexperiments.com/globe">
    <span>This is a Chrome Experiment</span>
  </a>

  <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
  <script type="text/javascript" src="static/third-party/Three/ThreeWebGL.js"></script>
  <script type="text/javascript" src="static/third-party/Three/ThreeExtras.js"></script>
  <script type="text/javascript" src="static/third-party/Three/RequestAnimationFrame.js"></script>
  <script type="text/javascript" src="static/third-party/Three/Detector.js"></script>
  <script type="text/javascript" src="static/third-party/Tween.js"></script>
  <script type="text/javascript" src="static/globe.js"></script>
  <script type="text/javascript">

    if(!Detector.webgl){
      Detector.addGetWebGLMessage();
    } else {

      var years = ['1990','1995','2000'];
      var container = document.getElementById('container');
      var globe = new DAT.Globe(container);
      console.log(globe);
      var i, tweens = [];

      var settime = function(globe, t) {
        return function() {
          new TWEEN.Tween(globe).to({time: t/years.length},500).easing(TWEEN.Easing.Cubic.EaseOut).start();
          var y = document.getElementById('year'+years[t]);
          if (y.getAttribute('class') === 'year active') {
            return;
          }
          var yy = document.getElementsByClassName('year');
          for(i=0; i<yy.length; i++) {
            yy[i].setAttribute('class','year');
          }
          y.setAttribute('class', 'year active');
        };
      };

      for(var i = 0; i<years.length; i++) {
        var y = document.getElementById('year'+years[i]);
        y.addEventListener('mouseover', settime(globe,i), false);
      }

      TWEEN.start();
	/*
      $.getJSON('static/population909500.json', {}, function(data, textStatus) {
    	  window.data = data;
          for (i=0;i<data.length;i++) {
            globe.addData(data[i][1], {format: 'magnitude', name: data[i][0], animated: true});
          }
          globe.createPoints();
          settime(globe,0)();
          globe.animate();
      });
      */
      $.getJSON('aurora/now', {}, function(data, textStatus) {
    	  window.data = data;

    	  var movement = 0.1;
    	  for (var t=0;t<2;t++) {
	    	  var buffer = [];
	    	  
	    	  // Northern hemisphere
	    	  for (i=0;i<data.n.length;i++) {
	    		 for (j=0;j<data.n[i].length;j++) {
	    			if (data.n[i][j] == 0) {
	    				continue;
	    			}
					var lonlat = conv_xy_to_latlong(i, j, true);
					var intensity = data.n[i][j]/50;
					
					var delta = (((i + j + t) % 2) - 1) * movement * intensity;
      
					buffer.push(lonlat[1]);
					buffer.push(lonlat[0]);
					buffer.push(intensity + delta);
	    		 }  
	    	  }
	    	  
	     	  // Southern hemisphere
	    	  for (i=0;i<data.s.length;i++) {
	    		 for (j=0;j<data.s[i].length;j++) {
	    			if (data.s[i][j] == 0) {
	    				continue;
	    			}
					var lonlat = conv_xy_to_latlong(i, j, false);
					var intensity = data.s[i][j]/50;
					
					var delta = (((i + j + t) % 2) - 1) * movement * intensity;
					
					buffer.push(lonlat[1]);
					buffer.push(lonlat[0]);
					buffer.push(intensity + delta);
	    		 }  
	    	  }   	  
	    	  globe.addData(buffer, {format: 'magnitude', name: "" + t, animated: true});
    	  }
          globe.createPoints();
          settime(globe,0)();
          globe.animate();
      });
      
      var conv_xy_to_latlong = function(x,y,NorS) {
    	  //NorS: true = north; false = south;

    	      var latitude;
    	      var longitude;
    	      var lower_lat = 34;
    	      var img_w = 200;
    	      var img_h = 200;
    	      
    	      // 0 < x < img_w maps to -180 < x < 180
    	      longitude = x * 360 / img_w - 180 ;

    	      if (NorS) {
    	          //north
    	          // y: 0 to 200 maps 90 to 34
    	          latitude = y * -1 * (90 - lower_lat)/img_h + 90;   
    	      } else {
    	          //south
    	          // y: 0 to 200 maps -34 to -90
    	          latitude = y * (-90 + lower_lat)/img_h - lower_lat;   
    	      }

    	      //console.log('long:'+longitude);
    	      //console.log('lat:'+latitude);
    	      return [longitude,latitude];

    	  };
      
  	$(function() {

		var i = 0;
		var code = function() {
			console.log("at step " + i + " using globe " + (i %2));
			new TWEEN.Tween(globe).to({time: i % 2},500).easing(TWEEN.Easing.Cubic.EaseOut).start();
			i++;
		};
		setInterval(code, 500);
		
		
		var parseResponse = function(status) {
			var patt = /.*<th .*>\w+<\/th><td .*>(\w+)<\/td>/g;
			return patt.exec(status)[1];
		};
		
		$.getJSON('aurora/weather', {}, function(data, textStatus) {
			console.log("received " + data);
			// sample response: {"condition_time":"Date : 2012-04-22 Time : 22:00","POL":"Polar<\/th>Quiet<\/td>","AUR":"Auroral<\/th>Quiet<\/td>","SUB":"Sub-Auroral<\/th>Quiet<\/td>"}
			$('#measure-time').html(data.condition_time);
			$('#pol_status').html(parseResponse(data.POL));
			$('#aur_status').html(parseResponse(data.AUR));
			$('#sub_status').html(parseResponse(data.SUB));
		});
		
		
	});
  }

	</script>

</body>

</html>
