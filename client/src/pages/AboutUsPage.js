import React from "react";
import "./AboutUs.css";
import uwt from "../components/uwt.jpg"
const AboutUsPage = () => {
  const myStyle={
    backgroundImage: 
    `url(${uwt})`,
    height:'100vh',
    marginTop:'-70px',
    fontSize:'50px',
    backgroundSize: 'cover',
    backgroundRepeat: 'no-repeat',
};
  return (
    <div className="AboutUs-wrapper">
      <div style = {myStyle}>
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
              help every broke college student eat healthy and save money
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
