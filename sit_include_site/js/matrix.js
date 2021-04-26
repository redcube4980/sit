$(function(){
	//文字を落とすのはcanvas機能を採用しています。
	//canvasについて詳しくはないので、ネットで見付けたソースを元に変更して作成。
	//"use strict";
	var Drops = function() {
		this.canvas = null;
		this.ctx = null;
		this.str = "ＳＴＡＲＩＮＦＯＴＥＣＨ　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　";
		this.strArray = this.str.split("");
		this.fontSize = 72;
		this.font = '72px sans-serif';
		this.columns = 0;
		this.dropArray = [];
		this.initialize();
	};
	Drops.prototype.initialize = function() {
		this.canvas = document.getElementById("canvas");
		if(!this.canvas.getContext) throw new Error("cannot get context.");
		this.ctx = this.canvas.getContext("2d");
		this.canvas.width = window.innerWidth;
		this.canvas.height = window.innerHeight;
		this.columns = this.canvas.width / this.fontSize;
		for(var i = 0; i < this.columns; i++) {
			this.dropArray[i] = 1;
		}
	};
	Drops.prototype.draw = function() {
		this.ctx.fillStyle = "rgba(255, 255, 255, 0.25)";
		this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
		this.ctx.fillStyle = "#ff6347";
		this.ctx.font = this.font;
		for(var i = 0; i < this.columns; i++) {
			var text = this.strArray[Math.floor(Math.random() * this.strArray.length)];
			this.ctx.fillText(text, i * this.fontSize, this.dropArray[i] * this.fontSize);
			if(this.dropArray[i] * this.fontSize > this.canvas.height || Math.random() > 0.95) {
				this.dropArray[i] = 0;
			}
			this.dropArray[i]++;
		}
	};
	Drops.prototype.main = function() {
		var instance = this;
		setInterval(function() {
			instance.draw(); 
		}, 200);
	};
	var drops = new Drops();
	drops.main();


	$("ul#menu").hide();
	$("#menus").click(function(){
		$("#menu").show();
		$("#menus").css('background-color','#A52B34');
	});
	$("#menu").hover(function(){
	},function(){
		$("ul#menu").hide();
		$("#menus").css('background-color','transparent');
	});
});