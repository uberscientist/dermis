define(function () {
  return function (_args, templ) {
    document.getElementById("testi").innerHTML = templ(_args);
  };
});