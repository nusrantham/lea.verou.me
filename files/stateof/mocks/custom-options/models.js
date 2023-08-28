import { Question, Option, SingleChoiceQuestion, MultiChoiceQuestion as BaseMultiChoiceQuestion } from '../base-models.js'

class CustomOption {
	value = "";
	active = false;

	constructor(question) {
		this.question = question;
	}

	// The checkbox of a custom option is a distraction:
	// when it is inconsistent with the presence or absence of text in the text field
	// (i.e. checking it without entering text or not checking it while entering text), that tends to be a mistake.
	// Better to disable it and use it entirely as output (checked if text is entered, unchecked if not).
	// This also improves keyboard UX and a11y by eliminating one pointless tab stop.
	get selected () {
		return !!this.value;
	}

	toJSON () {
		let ret = {...this};
		// Prevent cyclical structure errors
		delete ret.question;
		return ret;
	}
}


class MultiChoiceQuestion extends BaseMultiChoiceQuestion {
	customOptions = this.allowCustom ? [new CustomOption(this)] : [];

	get longform () {
		// If no predefined answers, we assume this is a freeform list
		// and would benefit from more space to enter answers
		// In the future we may want to make this configurable
		// and just default to this when it's not set
		return this.options.length === 0;
	}

	custom_option_changed (i) {
		let option = this.customOptions[i];
		let nextOption = this.customOptions[i + 1];

		if (option.value && !nextOption) {
			this.add_custom_option();
		}
	}

	add_custom_option (i = this.customOptions.length) {
		let option = new CustomOption(this);
		this.customOptions.splice(i, 0, option);
		return option;
	}

	remove_empty_custom_options () {
		for (let i = this.customOptions.length - 1; i > 0; i--) {
			let option = this.customOptions[i];
			if (!option.value) {
				this.customOptions.splice(i, 1);
			}
		}
	}
}

export {
	Option,
	CustomOption,
	Question,
	SingleChoiceQuestion,
	MultiChoiceQuestion,
}