window.addEventListener("load", initBs5);
window.addEventListener("turbolinks:load", initBs5);

function initBs5(event) {
  document.querySelectorAll('[data-bs5="copy"]').forEach(function (item) {
    item.addEventListener("click", handleBs5CopyButtonClick);
  });
}

function handleBs5CopyButtonClick(event) {
  var code = event.target.closest("div").querySelector("code").innerText;
  navigator.clipboard.writeText(code);
}
