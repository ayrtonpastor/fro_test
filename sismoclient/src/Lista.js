import Loading from "./Loading";
import Card from "react-bootstrap/Card";
import Button from "react-bootstrap/Button";
import { useNavigate } from "react-router-dom";

export default function Lista(props) {
	let navigate = useNavigate();

	// Función para manejar el cambio de página hacia atrás
	const handlePrevPage = () => {
		if (props.currentPage > 1) {
			props.onPageChange(props.currentPage - 1);
		}
	};

	// Función para manejar el cambio de página hacia adelante
	const handleNextPage = () => {
		props.onPageChange(props.currentPage + 1);
	};

	const fixNumber = (number) => {
		return (Math.round(number * 100) / 100).toFixed(2);
	};

	function formatDate(dateString) {
		const date = new Date(dateString);
		const options = { year: 'numeric', month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric' };
		return date.toLocaleDateString('es-ES', options);
	}

	return (
		<>
			<div className="pagination-container" style={{ marginTop: "20px" }}>
				{props.currentPage > 1 && (
					<Button className="pagination-button" onClick={handlePrevPage}>Anterior</Button>
				)}
				{props.currentPage !== props.totalPages && (
					<Button className="pagination-button" onClick={handleNextPage}>Siguiente</Button>
				)}
			</div>
			<div className="features-container">
				<ul className="feature-list">
					{props.features.map((feature, index) => {
						return (
							<li key={feature.id} className="feature-item">
								<Card className="feature-card">
									<Card.Body>
										<Card.Title className="feature-title">{feature.attributes.title}</Card.Title>
										<Card.Text>
											<p className="feature-info">Magnitud: {fixNumber(feature.attributes.magnitude)}</p>
											<p className="feature-info">Fecha y hora: {formatDate(feature.attributes.time)}</p>
											<p className="feature-info">Lugar: {feature.attributes.place}</p>
										</Card.Text>
										<Button
											className="ver-button"
											variant="primary"
											onClick={() => {
												navigate(`/features/${feature.id}`);
											}}
										>
											Ver
										</Button>
									</Card.Body>
								</Card>
							</li>
						);
					})}
				</ul>
			</div>
		</>
	);
}
