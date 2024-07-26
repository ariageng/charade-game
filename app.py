import subprocess
import os
from flask import Flask, render_template, jsonify

app = Flask(__name__)

def generate_sentences_with_gf(grammar_file, num_sentences=100):
    try:
        # Get the directory of the current script
        script_dir = os.path.dirname(os.path.abspath(__file__))
        # Create a file path in the same directory as the script
        tmpfile_name = os.path.join(script_dir, 'generated_sentences.txt')

        run_gf_command = ['gf', '--run']
        
        gf_commands = f"""
        i -retain {grammar_file}
        gr -cat=Utt -number={num_sentences} | linearize
        quit
        """
        
        process = subprocess.Popen(run_gf_command, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, cwd=script_dir)
        result_stdout, result_stderr = process.communicate(gf_commands)

        if process.returncode != 0:
            return None

        with open(tmpfile_name, 'w') as tmpfile:
            tmpfile.write(result_stdout)

        return tmpfile_name

    except Exception as e:
        return None

def select_sentence_from_file(file_path):
    try:
        with open(file_path, 'r') as file:
            sentences = file.readlines()

        for sentence in sentences:
            words = sentence.split()
            if len(words) > 1:
                return sentence.strip()

        return None

    except Exception as e:
        return None

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/generate', methods=['GET'])
def generate():
    grammar_file = 'MicroLangSwe.gf'
    num_sentences = 100

    tmpfile_name = generate_sentences_with_gf(grammar_file, num_sentences)
    if not tmpfile_name:
        return jsonify({'error': 'Error generating sentences.'})

    selected_sentence = select_sentence_from_file(tmpfile_name)
    if selected_sentence:
        return jsonify({'sentence': selected_sentence})
    else:
        return jsonify({'error': 'No sentence with more than 4 words found.'})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8080)
