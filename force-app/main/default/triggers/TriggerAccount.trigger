trigger TriggerAccount on Account (after insert, after update) {
	TriggerAccountHandler.processarAntesDeCriarOuAtualizar();
	TriggerAccountHandler.processarDepoisDeCriarOuAtualizar();
}