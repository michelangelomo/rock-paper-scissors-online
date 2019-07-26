import {Socket} from "phoenix"

let socket = new Socket("/socket", {})

socket.connect();

window.Socket = socket;

export default socket
