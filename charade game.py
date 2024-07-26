import subprocess
import os
import tkinter as tk
from tkinter import messagebox

def generate_sentences_with_gf(grammar_file, num_sentences=100):
    # Get the directory of the current script
    script_dir = os.path.dirname(os.path.abspath(__file__))
    # Create a file path in the same directory as the script
    tmpfile_name = os.path.join(script_dir, 'generated_sentences.txt')

    try:
        print(f"Starting GF process with grammar file: {grammar_file}")

        # Ensure we are using the same directory as the script
        run_gf_command = ['gf', '--run']
        
        # Prepare the complete set of GF commands
        gf_commands = f"""
        i -retain {grammar_file}
        gr -cat=Utt -number={num_sentences} | linearize
        quit
        """
        print(f"Sending commands to GF:\n{gf_commands}")

        # Run GF and send all commands in one go
        process = subprocess.Popen(run_gf_command, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, cwd=script_dir)
        
        result_stdout, result_stderr = process.communicate(gf_commands)
        print(f"GF Output:\n{result_stdout}")
        print(f"GF Error Output:\n{result_stderr}")

        if process.returncode != 0:
            print(f"An error occurred: {result_stderr}")
            return None

        # Save the generated sentences to a file
        with open(tmpfile_name, 'w') as tmpfile:
            tmpfile.write(result_stdout)

        print(f"Sentences saved to file: {tmpfile_name}")

        return tmpfile_name

    except Exception as e:
        print(f"An error occurred while generating sentences: {e}")
        return None

def select_sentence_from_file(file_path):
    try:
        print(f"Reading sentences from file: {file_path}")

        with open(file_path, 'r') as file:
            sentences = file.readlines()

        for sentence in sentences:
            words = sentence.split()
            if len(words) > 1:
                print(f"Selected sentence: {sentence.strip()}")
                return sentence.strip()

        print("No sentence with more than 4 words found.")
        return None

    except Exception as e:
        print(f"An error occurred while reading the file: {e}")
        return None


def on_generate_button_click(grammar_file, sentence_label):
    num_sentences = 100

    print(f"Generating sentences with grammar file: {grammar_file}")
    tmpfile_name = generate_sentences_with_gf(grammar_file, num_sentences)
    if not tmpfile_name:
        sentence_label.config(text="Error generating sentences.")
        return

    print(f"Selecting sentence from file: {tmpfile_name}")
    selected_sentence = select_sentence_from_file(tmpfile_name)
    if selected_sentence:
        sentence_label.config(text=selected_sentence)
        print(f"File saved at: {tmpfile_name}")
    else:
        sentence_label.config(text="No sentence with more than 4 words found.")


def create_gui(grammar_file):
    root = tk.Tk()
    root.title("Sentence Generator")
    
    # Add a label to display the selected sentence
    sentence_label = tk.Label(root, text="", font=('Helvetica', 24))
    sentence_label.pack(pady=20) # Add some padding around the label
    
    # Add a button to generate a sentence when clicked and display it in a label below the button
    generate_button = tk.Button(root, text="Generate Sentence", command=lambda: on_generate_button_click(grammar_file, sentence_label),
                                bg="black", fg="black", font=('Helvetica', 24, 'bold'), padx=20, pady=10)
    generate_button.pack(pady=20)
    
    root.mainloop()

def main():
    grammar_file = '/Users/gengtianyi/Downloads/MLT2023/LT2214/comp-syntax-gu-mlt-main2/lab2/grammar/myproject/MicroLangSwe.gf'

    create_gui(grammar_file)

if __name__ == "__main__":
    main()
