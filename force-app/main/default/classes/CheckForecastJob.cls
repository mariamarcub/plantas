public with sharing class CheckForecastJob implements Schedulable {
    public void execute(SchedulableContext SC) {
    
    }

    public static void postNotifications(){
        // Tareas a realizar
        // 1) Ver la temperatura de hoy
        ForecastService.Forecast fc = ForecastService.getTodaysTemperatures();
        Integer maxTempToday = Integer.valueOf(fc.temperaturas.max);
        Integer minTempToday = Integer.valueOf(fc.temperaturas.min);

        // 2) Mirar si hay alguna planta que no soporte dicha temperatura 
        List<Plant__c> plantsWithProblems = [
            SELECT Name, Specie__r.Max_Temperature__c, Specie__r.Min_Temperature__c
            FROM Plant__c 
            WHERE Specie__c IN (
                SELECT Id 
                FROM Specie__c 
                WHERE Max_Temperature__c < :maxTempToday OR Min_Temperature__c > :minTempToday
            )
        ];

        // 3) Si encuentro alguna, mandar notificación
        for (Plant__c plantsWithProblem : plantsWithProblems) {
            CustomNotificationType notificationType = [
                SELECT Id, DeveloperName 
                FROM CustomNotificationType             
                WHERE DeveloperName = 'Temperature_Alert' //Se vincula con la que hemos creado en Custom Notifications en Salesforce
            ];

            // Crear un new custom notification
            Messaging.CustomNotification notification = new Messaging.CustomNotification();

            if (plantsWithProblem.Specie__r.Max_Temperature__c < maxTempToday ) {
                setNotificationMessage('hot', notification);
            } else if (plantsWithProblem.Specie__r.Min_Temperature__c > minTempToday) {
                setNotificationMessage('cold', notification);
            }

            // Set de notificaciones
            notification.setNotificationTypeId(notificationType.Id);
            notification.setTargetId(plantsWithProblem.Id);

            try {
                notification.send(new Set<String> { UserInfo.getUserId()}) ;
                
            } catch (Exception e) {
                System.debug('Problem sending notification: ' + e.getMessage());
            }
        } // Cerramos for
    }

    private static void setNotificationMessage(String type, Messaging.CustomNotification notification) {
        if (type == 'hot') {
            notification.setTitle('Mucho calor para la planta');
            notification.setBody('Todo');
        } else if (type == 'cold') {
            notification.setTitle('Mucho frío para la planta');
            notification.setBody('Todo');
        }
    }
}