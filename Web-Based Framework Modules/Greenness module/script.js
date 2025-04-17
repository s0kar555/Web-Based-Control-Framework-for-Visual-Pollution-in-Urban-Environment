document.getElementById('upload-form').addEventListener('submit', function(e) {
    e.preventDefault(); // Prevent the default form submission

    const formData = new FormData(this);

    fetch('upload.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        console.log("Response data:", data); // Debug log for response data
        if (data.success) {
            console.log("Log messages:", data.log); // Debug log for log messages
            const uploadedImage = document.getElementById('uploaded-image');
            const maskImage = document.createElement('img');

            uploadedImage.src = data.upload_path;
            uploadedImage.style.display = 'block';

            maskImage.src = data.mask_path;
            maskImage.id = 'mask-image';
            maskImage.style.display = 'none';
            document.getElementById('image-container').appendChild(maskImage);

            // Show the green percentage from the Python script
            document.getElementById('python-green-value').textContent = data.green_percentage.toFixed(2) + '%';

            maskImage.onload = function() {
                highlightGreenAreas(uploadedImage, maskImage);
            };
        } else {
            console.error(data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });
});

function drawGridAndHighlights(image, greenCells, totalSquares) {
    const canvas = document.getElementById('grid-canvas');
    const ctx = canvas.getContext('2d');

    // Ensure the canvas size matches the image size
    const width = image.clientWidth;
    const height = image.clientHeight;
    canvas.width = width;
    canvas.height = height;

    // Update HTML elements with the values
    console.log(`Image Width: ${width}`);
    console.log(`Image Height: ${height}`);
    console.log(`Canvas Width: ${canvas.width}`);
    console.log(`Canvas Height: ${canvas.height}`);

    document.getElementById('image-width').textContent = width;
    document.getElementById('image-height').textContent = height;
    document.getElementById('canvas-width').textContent = canvas.width;
    document.getElementById('canvas-height').textContent = canvas.height;

    // Calculate dimensions based on the image size and desired grid size (1% of width and height)
    const cellWidth = width * 0.01;
    const cellHeight = height * 0.01;

    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.drawImage(image, 0, 0, width, height);

    for (let x = 0; x < width; x += cellWidth) {
        for (let y = 0; y < height; y += cellHeight) {
            ctx.strokeStyle = 'rgba(0, 0, 0, 0.5)';
            ctx.strokeRect(x, y, cellWidth, cellHeight);
        }
    }

    // Redraw the green cells based on stored positions
    greenCells.forEach(cellKey => {
        const [col, row] = cellKey.split('-').map(Number);
        const startX = col * cellWidth;
        const startY = row * cellHeight;
        ctx.fillStyle = 'rgba(0, 255, 0, 0.5)';
        ctx.fillRect(startX, startY, cellWidth, cellHeight);
    });

    document.getElementById('total-squares').textContent = totalSquares;
    document.getElementById('total-green-squares').textContent = greenCells.size;
}

function highlightGreenAreas(image, maskImage) {
    const maskCanvas = document.createElement('canvas');
    const maskCtx = maskCanvas.getContext('2d');
    maskCanvas.width = maskImage.naturalWidth;
    maskCanvas.height = maskImage.naturalHeight;
    maskCtx.drawImage(maskImage, 0, 0);

    const maskData = maskCtx.getImageData(0, 0, maskCanvas.width, maskCanvas.height);
    const width = maskImage.naturalWidth;
    const height = maskImage.naturalHeight;
    const cellWidth = width * 0.01;
    const cellHeight = height * 0.01;

    const greenCells = new Set();

    for (let col = 0; col < Math.floor(width / cellWidth); col++) {
        for (let row = 0; row < Math.floor(height / cellHeight); row++) {
            const startX = col * cellWidth;
            const startY = row * cellHeight;
            let greenPixelCount = 0;
            const cellPixelCount = cellWidth * cellHeight;

            for (let x = startX; x < startX + cellWidth; x++) {
                for (let y = startY; y < startY + cellHeight; y++) {
                    const idx = (Math.floor(y) * maskCanvas.width + Math.floor(x)) * 4;
                    if (maskData.data[idx] > 0) {
                        greenPixelCount++;
                    }
                }
            }

            if (greenPixelCount / cellPixelCount >= 0.5) {
                greenCells.add(`${col}-${row}`);
            }
        }
    }

    const totalSquares = Math.floor(width / cellWidth) * Math.floor(height / cellHeight);

    drawGridAndHighlights(image, greenCells, totalSquares);

    // Redraw grid on window resize
    window.addEventListener('resize', () => drawGridAndHighlights(image, greenCells, totalSquares));

    // Make grid interactive
    const canvas = document.getElementById('grid-canvas');
    canvas.addEventListener('click', function(event) {
        const rect = canvas.getBoundingClientRect();
        const x = event.clientX - rect.left;
        const y = event.clientY - rect.top;
        const col = Math.floor(x / (canvas.width * 0.01));
        const row = Math.floor(y / (canvas.height * 0.01));
        const cellKey = `${col}-${row}`;
        const mode = document.getElementById('mode-switch').value;

        if (mode === 'add' && !greenCells.has(cellKey)) {
            greenCells.add(cellKey);
        } else if (mode === 'remove' && greenCells.has(cellKey)) {
            greenCells.delete(cellKey);
        }

        drawGridAndHighlights(image, greenCells, totalSquares);

        // Update green percentage and total green squares
        const newGreenPercentage = (greenCells.size / totalSquares) * 100;
        document.getElementById('js-green-value').textContent = newGreenPercentage.toFixed(2) + '%';
        document.getElementById('total-green-squares').textContent = greenCells.size;
    });

    // Add reset functionality
    document.getElementById('reset-all').addEventListener('click', function() {
        greenCells.clear();
        drawGridAndHighlights(image, greenCells, totalSquares);
        document.getElementById('js-green-value').textContent = '0%';
        document.getElementById('total-green-squares').textContent = '0';
    });
}
