const http = require('http');

function testEndpoint(url) {
  return new Promise((resolve, reject) => {
    http.get(url, (res) => {
      let data = '';
      res.on('data', (chunk) => {
        data += chunk;
      });
      res.on('end', () => {
        resolve({
          statusCode: res.statusCode,
          headers: res.headers,
          body: data
        });
      });
    }).on('error', (err) => {
      reject(err);
    });
  });
}

async function run() {
  console.log("Testing search suggestions API on localhost:3002...");
  try {
    const response = await testEndpoint('http://localhost:3002/api/search/suggestions?q=Panadol');
    console.log(`Status Code: ${response.statusCode}`);
    console.log("Response Body:", JSON.stringify(JSON.parse(response.body), null, 2));
  } catch (error) {
    console.error("Error connecting to localhost:3002:", error.message);
  }
}

run();
