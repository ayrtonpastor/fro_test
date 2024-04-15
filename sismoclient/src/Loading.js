import logo from './logo.svg';

export default function Loading(props) {
	return (
		<>
			<img
				id="loading"
				className="spinner"
				src={logo}
				alt="loading icon"
			/>
			<h3 className="mensaje">Cargando...</h3>
		</>
	);
}
