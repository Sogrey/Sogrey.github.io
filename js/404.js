var _DENSITY = 20;
var _FPS = 30;
var _OPACITY = 0.50;
(function($) {
    $.fn.effect = function(opts) {
        var element = this;
        $(element).children().each(function(index) {
            var that = this;
            var opacity = Math.round((1 / $(that).offset().top) * ($(window).height() / 2 + $(window).scrollTop()) * 100) / 100;
            $(that).find(".effect").css({
                "opacity": opacity >= 1 ? 1 : 0
            });
        });
        return (this);
    };
    $.fn.engine = function(opts) {
        var element = this;
        var density = _DENSITY;
        var fps = _FPS;
        var ratio = Math.round(window.devicePixelRatio ? window.devicePixelRatio : 1);
        var stack = [];
        var cvs = $(element).find(".animation").get(0);
        var ctx = cvs.getContext("2d");
        var count = 0;
        var fn = function() {
            cvs.width = $(element).width() * ratio;
            cvs.height = $(element).height() * ratio;
            ctx.clearRect(0, 0, cvs.width, cvs.height);
            $(stack).each(function(index) {
                var obj = this;
                var x = _OPACITY - _OPACITY / (cvs.width / 2) * Math.abs(cvs.width / 2 - obj.position.x);
                var y = _OPACITY - _OPACITY / (cvs.height / 2) * Math.abs(cvs.height / 2 - obj.position.y);
                ctx.beginPath();
                ctx.arc(obj.position.x, obj.position.y, obj.speed.x * obj.speed.y % (50 * ratio) + (10 * ratio), (0 * Math.PI), (2 * Math.PI));
                ctx.globalAlpha = x <= 2="" 64="" 192="" 1000="" y="" ?="" x="" :="" y;="" ctx.fillstyle="rgba(" +="" obj.color.r="" ",="" "="" obj.color.g="" obj.color.b="" 1)";="" ctx.fill();="" ctx.closepath();="" obj.position.x="((obj.speed.x" %="" obj.speed.x="" fps="" -="" fps)="" cvs.width)="" cvs.width;="" obj.position.y="((obj.speed.y" obj.speed.y="" cvs.height)="" cvs.height;="" });="" };="" while="" (density--)="" {="" stack.push({="" "position":="" "x":="" math.round(math.random()="" *="" 1000000)="" ($(element).width()="" ratio),="" "y":="" ($(element).height()="" ratio)="" },="" "speed":="" (50="" "color":="" "r":="" 192,="" "g":="" "b":="" }="" fn();="" setinterval(function()="" fps);="" $(window).bind("load="" resize="" scroll",="" function(event)="" var="" opacity="Math.round((1" $(element).height()="" $(window).scrolltop())="" 100)="" 100;="" margin="Math.round($(element).height()" $(element).find(".content").height()="" $(window).scrolltop()="" 4);="" $(element).find(".animation").css({="" "opacity":="">= 0 ? opacity : 0
            });
        });
        return (this);
    };
})(jQuery);</=>