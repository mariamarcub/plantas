public with sharing class ForecastService {
    public static Forecast getTodaysTemperatures() {
        HttpRequest req = New HttpRequest();
        req.SetEndPoint('callout:El_tiempo/api/json/v2/provincias/18/municipios/18087'); //Named credential
        req.setMethod('GET');

        Http http = new Http();
        HttpResponse res = http.send(req);
        String body = res.getBody(); //Está serializado

        //Deserializar

        Forecast forecast = (Forecast)JSON.deserialize(body, Forecast.class);
        return forecast;
    }

    public class Forecast {

        public Temperatures temperaturas; //se tiene que llamar igual que en el json

    }

    public class Temperatures{
        public String max;
        public String min;

    }
}