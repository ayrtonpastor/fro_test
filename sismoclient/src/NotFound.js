import Button from "react-bootstrap/Button";
import { useNavigate } from "react-router-dom";

export default function NotFound(props) {
	let navigate = useNavigate();

	return (
		<div>
			<div>Ruta no encontrada</div>
			<Button
				id="volver"
				variant="danger"
				onClick={() => {
					navigate("/");
				}}
			>
				Volver
			</Button>
		</div>
	);
}
