import './App.css';
import Header from "./Header";
import Loading from "./Loading";
import Lista from "./Lista";
import Feature from "./GeoFeature";
import NotFound from "./NotFound";
import CONFIG from "./config/config";
import { useState } from "react";
import { useEffect } from "react";
import { Route, Routes } from "react-router-dom";

function App() {
  const [loading, setLoading] = useState(true);
  const [features, setFeatures] = useState([]);
  const [currentPage, setCurrentPage] = useState(1); // Estado para la página actual

  useEffect(() => {
    async function fetchData() {
      try {
        let path = `${CONFIG.server_url}/api/features?page=${currentPage}&per_page=${CONFIG.num_items}`;
        const response = await fetch(path);
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        const jsonData = await response.json();
        setFeatures(jsonData.data);
      } catch (error) {
        console.error('Error fetching data:', error);
        setFeatures([]);
      }
      setLoading(false);
    }

    setTimeout(() => {
      fetchData();
    }, CONFIG.loading_timeout_ms);
  }, [currentPage]); // Hacer que useEffect se ejecute cada vez que cambie currentPage

  // Función para manejar el cambio de página
  const handlePageChange = (newPage) => {
    setCurrentPage(newPage);
  };

  return (
    <div>
      <Header />
      <Routes>
        <Route
          path="/"
          element={
            loading ? <div className="loading-container">
              <Loading />
            </div> : <Lista features={features} currentPage={currentPage} onPageChange={handlePageChange} />
          }
        ></Route>
        <Route
          path="/features/:featureId"
          element={loading ? <div className="loading-container">
            <Loading />
          </div> : <Feature features={features} />}
        />
        <Route
          path="/features/add_comment/:featureId"
          element={loading ? <div className="loading-container">
            <Loading />
          </div> : <Feature features={features} />}
        />
        <Route path="*" element={loading ? <div className="loading-container">
          <Loading />
        </div> : <NotFound />} />
      </Routes>
    </div>
  );
}

export default App;
