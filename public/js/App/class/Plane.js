// Generated by CoffeeScript 1.4.0
(function(){var e,t=function(e,t){return function(){return e.apply(t,arguments)}};e=function(){function e(e){this.update=t(this.update,this);var n=this;this.data={};this.path=new google.maps.MVCArray;this.histo=[];this.redisCount=0;this.obj=new google.maps.Polyline({strokeColor:"#FFFFFF",strokeOpacity:.1,strokeWeight:1.05});google.maps.event.addListener(this.obj,"click",function(){n.obj.setMap(null);return console.log(n)});this.obj.setMap(e);this.obj.setPath(new google.maps.MVCArray([this.path]));return this}e.prototype.update=function(e){this.data.type=e[0];this.data.registre=e[1];this.data.flynumber2=e[2];this.data.l_lat=this.data.lat!=null?this.data.lat:null;this.data.l_lon=this.data.lon!=null?this.data.lon:null;this.data.lat=e[3];this.data.lon=e[4];this.data.alt=e[5];this.data.angle=e[6];this.data.speed=e[7];this.data.timestamp=e[8];this.data.unknow=e[9];this.data.flynumber1=e[10];this.data.course=e[11];this.path.insertAt(this.path.length,new google.maps.LatLng(this.data.lat,this.data.lon));this.histo.push([this.data.lat,this.data.lon]);this.redisCount+=1;return this};return e}();window.Plane=e}).call(this);