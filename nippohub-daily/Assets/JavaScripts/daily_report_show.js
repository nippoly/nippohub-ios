window.addEventListener('load', () => {
    const labelTitle = document.getElementById("js-daily-report-title");
    const labelContent = document.getElementById("js-daily-report-content");
                        
    labelTitle.textContent = "test";
    labelContent.innerHTML = marked("# hello world \n- list1\n-list2");
})
