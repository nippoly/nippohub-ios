marked.setOptions({sanitize: true});

// iOSからの呼び出しがある
function rendering(title, content) {
    const labelTitle = document.getElementById("js-daily-report-title");
    const labelContent = document.getElementById("js-daily-report-content");
                        
    labelTitle.textContent = title;
    marked.setOptions({sanitize: true});
    labelContent.innerHTML = marked(content);
}
