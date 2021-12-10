import React from "react";
import "./AboutUs.css";
const AboutUsPage = () => {
  return (
    <div className="AboutUs-wrapper">
      <div className="backg-image">
        <div className = "bod">
        <div className="row">
      <div className="col-md-12 text-center">
        <div className = "textWr">
        <div className = "main-heading">
          <h3>Our Mission</h3>
          <div className="underline mx-auto"></div>
          <div className="con">
            <p>Our talented team of students came together to design a web application for college students
              who moved from their parents house to out of state college or dorms and want to find budget oreinted recipes. 
              Our project is going to focus on providing students with a high quality meal on a reasonable cost.  
              Our budget friendly recipes will help students learn how to cook, prepare high quality food, and save money in the process.
            </p>
          </div>
        </div>
        </div>
      </div>
      </div>
      <div className="row">
      <div className="col-md-12 text-center">
      <div className = "textWr">
        <div className = "main-heading">
          <h3>Our Vision</h3>
          <div className="underline mx-auto"></div>
          <div className="con">
            <p>
              We want college students to become self sufficient and take care of themself when their parents are no longer with them.
              We want to teach every college student important skill such us cooking and 
              help them eat healthy food and save money.
            </p>
          </div>
        </div>
        </div>
      </div>
      </div>
        </div>
      </div>
    </div>
  );
};

export default AboutUsPage;
