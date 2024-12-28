    async function healthCheck() {
            const response = await fetch('./health');
            const data = await response.json();
            let isServiceUP = data.statusCode !== 500;
            return isServiceUP;
    }

healthCheck().then(isHealthy => {
    if(!isHealthy){
         window.location.href = './500';
    }
});