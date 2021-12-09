import React from 'react';
import { useState, useEffect } from 'react';
import { Table, Row, Col, FloatingLabel, Form } from 'react-bootstrap';
import './BrowseRecipes.css';
import parser from 'html-react-parser';

const MealPlanner = () => {
  return (
    <div style={{ marginTop: '40px' }} className="browse-recipes-content">
      <Row className="g-2">
        <Col md>
          <FloatingLabel controlId="floatingInputGrid" label="Enter a Price">
            <Form.Control type="number" placeholder="10" />
          </FloatingLabel>
        </Col>
        <Col md>
          <FloatingLabel controlId="floatingSelectGrid" label="Meal Type">
            <Form.Select aria-label="Floating label select example">
              <option value="1">Breakfast</option>
              <option value="2">Lunch</option>
              <option value="3">Dinner</option>
              <option value="4">Drink</option>
            </Form.Select>
          </FloatingLabel>
        </Col>
      </Row>
    </div>
  );
};

export default MealPlanner;
