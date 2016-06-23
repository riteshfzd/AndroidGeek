trigger MyContent on ContentVersion (After Insert,After update) {

system.debug('>>>>trigger.new--Ritesh>'+trigger.new);

System.debug('basic flow testing');

}