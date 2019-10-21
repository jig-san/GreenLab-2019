//Script used to find the loadtime of a webpage and send it to a local server.
<script type="text/javascript">
            var Start = Date.now();
            window.addEventListener('load', function() {
                //var loadTime = performance.now();
		var loadTime = performance.timing.responseEnd - performance.timing.navigationStart
                console.log("Fiered load after " + loadTime + " ms"); 
                var xhr = new XMLHttpRequest();
                //timing = btoa(loadTime.toString()) +  document.URL 
                // Use the above timing var if you have the domain name as a part of the file path
                timing = btoa(loadTime.toString())
		name = document.URL
                xhr.open("GET", "http://192.168.1.92:8080/Timing="+name+"?"+timing, true);
                xhr.onload = function () {
                    console.log("Timing sent Successfully");
                };
                xhr.send();
                }, false);
        </script>

