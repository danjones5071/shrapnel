import React from 'react';
import { Route } from 'react-router-dom';
import IssueEditor from './IssueEditor';

const App = () => (
  <div>
    <Route path="/issues/:id?" component={IssueEditor} />
  </div>
);

export default App;