import { BrowserRouter, Routes, Route } from "react-router-dom";
import LandingPage from "./pages/LandingPage";
import LoginPage from "./pages/LoginPage";
import NotFound from "./pages/NotFound";
import RegisterPage from "./pages/RegisterPage";
import BrowseRecipes from "./pages/BrowseRecipes";
import AboutUsPage from "./pages/AboutUsPage"
export const Router = () => {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" exact element={<LandingPage />} />
        <Route path="/login" exact element={<LoginPage />} />
        <Route path="/register" exact element={<RegisterPage />} />
        <Route path="/browseRecipes" exact element={<BrowseRecipes />} />
        <Route path="/aboutUs" exact element={<AboutUsPage />} />
        <Route path="*" element={<NotFound />} />
      </Routes>
    </BrowserRouter>
  );
};
