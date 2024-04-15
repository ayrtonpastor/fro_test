import { useEffect } from "react";
import CONFIG from "./config/config";
import React, { useState } from "react";
import Card from "react-bootstrap/Card";
import Loading from "./Loading";
import Button from "react-bootstrap/Button";
import { useNavigate, useParams } from "react-router-dom";

import { BsArrowLeft } from "react-icons/bs";

export default function Feature() {
	let navigate = useNavigate();
	let { featureId } = useParams();

	const [feature, setFeature] = useState(null);
	const [body, setComment] = useState("");
	const [comments, setComments] = useState([]);

	useEffect(() => {
		async function fetchData() {
			try {
				let path = `${CONFIG.server_url}/api/features/${featureId}`;
				const response = await fetch(path);
				if (!response.ok) {
					throw new Error('Network response was not ok');
				}
				const jsonData = await response.json();
				setFeature(jsonData);
				setComments(jsonData.comments);
			} catch (error) {
				console.error('Error fetching data:', error);
				setFeature(null);
			}
		}

		setTimeout(() => {
			fetchData();
		}, CONFIG.loading_timeout_ms);
	}, []);

	const fixNumber = (number) => {
		return (Math.round(number * 100) / 100).toFixed(2);
	};

	function formatDate(dateString) {
		const date = new Date(dateString);
		const options = { year: 'numeric', month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric' };
		return date.toLocaleDateString('es-ES', options);
	}

	const handleSubmit = async () => {
		try {
			const response = await fetch(`${CONFIG.server_url}/api/features/comments/${featureId}`, {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify({ body })
			});
			if (response.ok) {
				const data = await response.json();
				setFeature(data);
				setComments(data.comments);
				setComment("");
			} else {
				console.error("Error al enviar el comentario:", response.statusText);
			}
		} catch (error) {
			console.error("Error al enviar el comentario:", error);
		}
	};

	return (
		<div className="feature-container">
			{feature ? (
				<>
					<div className="comment-section">
						<Button
							id="volver"
							variant="danger"
							onClick={() => {
								navigate("/");
							}}
						>
							<BsArrowLeft className="back-icon" /> Volver
						</Button>
					</div>

					<div className="feature-info">
						<Card className="feature-card">
							<Card.Body>
								<Card.Title>{feature.attributes.title}</Card.Title>
								<Card.Text>
									Fecha y hora: {formatDate(feature.attributes.time)}
									<br />
									Lugar: {feature.attributes.place}
									<br />
									Coordenadas: {fixNumber(feature.attributes.coordinates.longitude)}, {fixNumber(feature.attributes.coordinates.latitude)}
									<br />
									Tipo: {feature.attributes.mag_type}
									<br />
									Magnitud: {feature.attributes.magnitude}
									<br />
									¿Provocó tsunami?: {feature.attributes.tsunami ? "Si" : "No"}
									<br /><br />
									<div class="info-link-container">
										<a href={feature.links.external_url} rel="noreferrer" target="_blank">Mayor información</a>
									</div>
								</Card.Text>
							</Card.Body>
						</Card>
					</div>

					<div className="comment-section">
						<h2>Comentarios</h2>
						<textarea
							className="comment-input"
							value={body}
							onChange={e => setComment(e.target.value)}
							placeholder="Ingrese su comentario"
						></textarea>
						<Button className="submit-button" onClick={handleSubmit}>Enviar Comentario</Button>
						<ul className="comment-list">
							{comments.map((comment, index) => (
								<li key={index} className="comment-item">
									<div className="comment-content">
										<span className="comment-body">{comment.body}</span>
									</div>
									<div className="comment-date">{formatDate(comment.created_at)}</div>
								</li>
							))}
						</ul>
					</div>
				</>
			) : (
					<Loading />
			)}
		</div>
	);
}
