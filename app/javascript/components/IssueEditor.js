import axios from 'axios';
import React from 'react';
import Header from './Header';
import IssueList from './IssueList';

class IssueEditor extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      issues: null,
    };
  }

  componentDidMount() {
    axios
      .get('/api/v1/issues.json')
      .then(response => this.setState({ issues: response.data }))
      .catch((error) => {
        console.log(error);
      });
  }

  render() {
    const { issues } = this.state;
    if (issues === null) return null;

    return (
      <div>
        <Header />
        <IssueList issues={issues} />
      </div>
    );
  }
}

export default IssueEditor;