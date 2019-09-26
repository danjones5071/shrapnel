import { BrowserRouter } from 'react-router-dom';
import React from 'react';
import { render } from 'react-dom';
import App from '../components/App';

document.addEventListener('DOMContentLoaded', () => {
  render(
    <BrowserRouter>
      <App />
    </BrowserRouter>,
    document.querySelector('#root')
  );
});