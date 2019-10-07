
            var Start = Date.now();
            /*
                The readystatechange event is fired when the  readyState attribute of a document has changed.
                The Document.readyState property describes the loading state of the document.
            */
            document.addEventListener('readystatechange', function() { console.log("Fiered '" + document.readyState + "' after " + performance.now() + " ms"); });
            /*
                The DOMContentLoaded event fires when the initial HTML document has been completely loaded and parsed, without waiting for stylesheets, images, and subframes to finish loading.
            */
            document.addEventListener('DOMContentLoaded', function() { console.log("Fiered DOMContentLoaded after " + performance.now() + " ms"); }, false); 
            /*
                The load event is fired when the whole page has loaded, including all dependent resources such as stylesheets images. This is in contrast to DOMContentLoaded, which is fired as soon as the page DOM has been loaded, without waiting for resources finish loading
            */
            window.addEventListener('load', function() { console.log("Fiered load after " + performance.now() + " ms"); }, false);
      
