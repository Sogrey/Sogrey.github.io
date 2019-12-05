var SogreyJs = (function(){

	var clearConsole = function(){
        console.clear();
        try {
            window.console && window.console.clear && console.clear();
            window.console && window.console.log && console.log('%c %c\nWelcome to%c\nSogrey\'s Blog\n%chttps://sogrey.github.io \n',

                'padding:15px 200px;background:url(https://sogrey.github.io/img/logo/sogrey.github.io.svg) no-repeat;height:1px;line-height:250px;',
                'text-shadow:1px 1px 5px rgba(0,0,0.2);font-size:20px;',
                'text-shadow:1px 1px 3px rgba(0,0,0.2);font-size:40px;',
                'font-size:30px;font-weight: 500;color: #3eaf7c !important;text-decoration: none;'
                );
        } catch (e) {}
	}

	return {
		init:function(){
			clearConsole();
		}
	}
})();
$(function(){
	SogreyJs.init();
})
