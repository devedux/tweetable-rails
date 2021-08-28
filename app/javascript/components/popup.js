const popup_transparent = () => {
  const flashMessage = document.querySelector('.popup__container');

  const fadeOutFlashMessage = () => {

    const timer_id = setInterval(() => {

      const opacity = flashMessage.style.opacity;

      if (opacity > 0) {
        flashMessage.style.opacity = opacity - 0.02;
      } else {
        flashMessage.style.display = 'none';
        clearInterval(timer_id);
      };

    }, 50); 
  }

  if (flashMessage !== null) {
    flashMessage.style.opacity = 1;
    setTimeout(fadeOutFlashMessage, 3000);
  };
}

document.addEventListener('turbolinks:load', popup_transparent)
