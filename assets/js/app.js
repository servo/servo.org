$(() => {
  const burger = $(".navbar-burger");
  const menu = $(".navbar-menu");
  burger.click(() => {
    [burger, menu].forEach((el) => el.toggleClass('is-active'));
  });
});
