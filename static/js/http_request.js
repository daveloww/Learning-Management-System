// API Request Functions
async function sendPostRequest(url, body) {
	const response = await fetch(url, {
        method: "POST",
        mode: "cors", 
        headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
        },
        body: body,
    });
    
	return response.json();
}

async function sendGetRequest(url) {
    const response = await fetch(url, {
        method: "GET",
        mode: "cors", 
        headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
        },
    });
    
    return response.json();
}

async function sendPutRequest(url) {
    const response = await fetch(url, {
        method: "PUT",
        mode: "cors", 
        headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
        },
    });
    
    return response.json();
}

async function sendDelRequest(url) {
    const response = await fetch(url, {
        method: "DELETE",
        mode: "cors", 
        headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
        },
    });
    
    return response.json();
}