import asyncio
import websockets

connected_clients = set()

async def handler(websocket):
    connected_clients.add(websocket)
    print(f"Client connected. Total: {len(connected_clients)}")

    try:
        async for message in websocket:
            print(f"Received: {message}")

            disconnected = set()

            for client in connected_clients:
                try:
                    await client.send(message)
                except websockets.ConnectionClosed:
                    disconnected.add(client)

            connected_clients.difference_update(disconnected)

    except websockets.ConnectionClosed:
        pass

    finally:
        connected_clients.discard(websocket)
        print(f"Client disconnected. Total: {len(connected_clients)}")

async def main():
    print("WebSocket server started on ws://0.0.0.0:8765")

    async with websockets.serve(handler, "0.0.0.0", 8765):
        await asyncio.Future()

if __name__ == "__main__":
    asyncio.run(main())