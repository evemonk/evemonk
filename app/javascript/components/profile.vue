<template>
    <div>
        <h1>Profile</h1>

        <h2>Email: {{ email }}</h2>
        <h1>Characters count: {{ characters_count }}</h1>
    </div>
</template>

<script>
    import { mapActions } from 'vuex';

    export default {
        data () {
            return {
                email: '',
                characters_count: null
            }
        },

        created () {
            this.fetchProfile().then(response => {
                if (response.status === 200)
                {
                    this.email = response.data.email;
                    this.characters_count = response.data.characters_count;
                } else {
                    this.$router.push('/sign_in');
                }
            });
        },

        methods: {
            ...mapActions({
                'fetchProfile': 'fetchProfile'
            })
        }
    }
</script>
