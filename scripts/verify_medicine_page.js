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
          body: data
        });
      });
    }).on('error', (err) => {
      reject(err);
    });
  });
}

async function run() {
  // Test the medicine page renders (server-side)
  console.log("=== Testing Medicine Page for Panadol ===");
  try {
    // First get Panadol's ID via suggestions
    const sugRes = await testEndpoint('http://localhost:3002/api/search/suggestions?q=Panadol');
    const sugData = JSON.parse(sugRes.body);
    console.log(`Suggestions found: ${sugData.suggestions.length}`);
    
    if (sugData.suggestions.length > 0) {
      const panadolId = sugData.suggestions[0].id;
      console.log(`Panadol ID: ${panadolId}`);
      
      // Fetch the medicine detail page 
      const medRes = await testEndpoint(`http://localhost:3002/medicine/${panadolId}`);
      console.log(`Medicine page status: ${medRes.statusCode}`);
      
      // Check for key content in the HTML
      const html = medRes.body;
      const hasAlreadyCheapest = html.includes('already the cheapest') || html.includes('cheapest option');
      const hasCheaperAlts = html.includes('Save ');
      const hasCommonSideEffects = html.includes('Common Side Effects');
      const hasDisclaimer = html.includes('Showing common side effects only');
      
      console.log(`\n--- Content Checks ---`);
      console.log(`Has "already cheapest" message: ${hasAlreadyCheapest}`);
      console.log(`Has cheaper alternatives with savings: ${hasCheaperAlts}`);
      console.log(`Shows "Common Side Effects" header: ${hasCommonSideEffects}`);
      console.log(`Shows disclaimer: ${hasDisclaimer}`);
      
      // Count side effect items
      const sideEffectMatches = html.match(/side-effect-item|divide-slate-100/g);
      console.log(`Side effects section present: ${sideEffectMatches ? 'yes' : 'no'}`);
    }
  } catch (error) {
    console.error("Error:", error.message);
  }
}

run();
