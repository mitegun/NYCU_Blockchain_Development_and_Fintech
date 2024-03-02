    for level in range(height):
        # Calculate the index of the parent node at the current level
        parent_index = level_pos // 2

        # Retrieve the left and right nodes
        left = state[level_pos] if level_pos < len(state) else b"\x00"
        right = state[level_pos + 1] if level_pos + 1 < len(state) else b"\x00"

        # Calculate the hash of the internal node and append it to the proof path
        path.append(hash_internal_node(left, right))

        # Update the state for the parent node at the current level
        state = [hash_internal_node(state[i], state[i+1]) for i in range(0, len(state), 2)]

        # Update the position to the parent node at the next level
        level_pos = parent_index