import * as bootstrap from "bootstrap";

function popoverify() {
  document
    .querySelectorAll('[data-bs-toggle="popover"]')
    .forEach(function (popoverTriggerEl) {
      new bootstrap.Popover(popoverTriggerEl);
    });
}

function toastify() {
  document.querySelectorAll(".toast").forEach(function (toastNode) {
    let autohide = new RegExp("true", "i").test(
      toastNode.dataset["bsAutohide"] || "false"
    );
    let toast = new bootstrap.Toast(toastNode, {
      autohide,
    });
    toast.show();
  });
}

function tooltipify() {
  document
    .querySelectorAll('[data-bs-toggle="tooltip"]')
    .forEach(function (tooltipTriggerEl) {
      new bootstrap.Tooltip(tooltipTriggerEl);
    });
}

export function start() {
  popoverify();
  toastify();
  tooltipify();
}
