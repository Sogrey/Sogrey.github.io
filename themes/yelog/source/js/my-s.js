var SogreyJs = (function () {

        var clearConsole = function () {
                try {
                        window.console && window.console.clear && console.clear();
                        window.console && window.console.log && console.log('%c %c\nWelcome to%c\nSogrey\'s Blog\n%chttps://sogrey.top \n',

                                'padding:50px 200px;background:url(https://sogrey.top/img/logo/sogrey.github.io.svg) no-repeat center center;background-size:contain;height:100px;line-height:100px;',
                                'text-shadow:1px 1px 5px rgba(0,0,0.2);font-size:20px;',
                                'text-shadow:1px 1px 3px rgba(0,0,0.2);font-size:40px;',
                                'font-size:25px;font-weight: 500;color: #3eaf7c !important;text-decoration: none;'
                        );
                } catch (e) {}
        }

        return {
                init: function () {
                        clearConsole();
                }
        }
})();
window.onload = function () {
        SogreyJs.init();
}
